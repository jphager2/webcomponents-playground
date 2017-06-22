require 'git'
require 'yaml'
require 'english'

class ComponentManager
  COMPONENTS_DIR = 'web/components'.freeze
  COMPONENTS_FILE = 'components.lock'.freeze

  def export(*)
    components = []

    in_components_dir do
      Dir.entries(Dir.pwd).drop(2).each do |repo|
        Dir.chdir(repo) do
          begin
            git = Git.open(Dir.pwd)
            remote = git.remotes.first.url
            component = remote.split(':').last.sub(/\.git$/, '')
            branch = git.current_branch
            commit = git.log.first.sha

            components << {
              component: component, branch: branch, commit: commit
            }
          rescue => e
            puts "Repo in bad format (#{repo}): #{e.message}"
            fail
          end
        end
      end
    end

    write_components(components)
  end
  
  def import(*)
    clone_components(read_components)
  end

  def install(args)
    components = extract_components(args)
    clone_components(components)
  end

  private

  def extract_components(args)
    component = args[0]
    branch = args[1]
    commit = args[2]

    [
      { component: component, branch: branch, commit: commit }
    ]
  end

  def clone_components(components)
    in_components_dir do
      components.each do |component|
        clone_component(component)
      end
    end
  end

  def clone_component(component_meta)
    component = component_meta.fetch(:component)
    branch = component_meta.fetch(:branch)
    commit = component_meta.fetch(:commit)

    url = git_url(component)
    dir = git_dir(component)

    begin
      git = Git.clone(url, dir)
      git.checkout(branch) if branch && false
      git.checkout(commit) if commit && false
    rescue => e
      warn e.message
    end
  end

  def git_url(component)
    "git@github.com:#{component}.git"
  end

  def git_dir(component)
    component.split('/').last
  end

  def setup_components_dir!
    Dir.mkdir(components_dir) unless Dir.exist?(components_dir)
  end

  def setup_components_file!
    return if File.exist?(components_file)

    write_components([])
  end

  def in_components_dir(&block)
    setup_components_dir!
    Dir.chdir(components_dir, &block)
  end

  def write_components(components)
    File.open(components_file, 'w') { |f| f.write(components.to_yaml) }
  end

  def read_components
    setup_components_file!
    
    YAML.load(File.read(components_file))
  end

  def components_dir
    COMPONENTS_DIR
  end

  def components_file
    COMPONENTS_FILE
  end
end

if $PROGRAM_NAME == __FILE__
  argv = ARGV.dup
  manager = ComponentManager.new
  action = argv.shift.to_s.to_sym

  unless manager.public_methods.include?(action)
    puts "#{action} is not a known action"
    exit(1)
  end

  manager.public_send(action, argv)
end
