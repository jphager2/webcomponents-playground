require 'git'
require 'yaml'
require 'english'

module ComponentManager
  COMPONENTS_DIR = 'components'.freeze
  COMPONENTS_FILE = 'components.lock'.freeze

  module_function

  def export
    components = []

    in_components_dir do
      Dir.entries(Dir.pwd).drop(2).each do |repo|
        Dir.chdir(repo) do
          begin
            git = Git.open(Dir.pwd)
            remote = git.remotes.first.url.split(':').last.sub(/\.git$/, '')
            components << remote
          rescue => e
            puts "Repo in bad format (#{repo}): #{e.message}"
            fail
          end
        end
      end
    end

    write_components(components)
  end
  
  def import
    components = read_components

    in_components_dir do
      components.each do |component|
        begin
          Git.clone("git@github.com:#{component}.git", component.split('/').last)
        rescue => e
          warn e.message
        end
      end
    end
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

ALLOWED_ACTIONS = %w(import export).freeze

if $PROGRAM_NAME == __FILE__
  action = ARGV[0]

  unless ALLOWED_ACTIONS.include?(action)
    puts "#{action} is not a known action"
    exit(1)
  end

  ComponentManager.__send__(action)
end
