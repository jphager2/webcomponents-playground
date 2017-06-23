# Web Components Playground

Playing around with web components.

## Requirements:

- node
- ruby (for setup)

## Setup

```
git clone git@github.com:jphager2/webcomponents-playground
cd webcomponents-playground
ruby scripts/component_manager.rb import
```

## Running the server

```
npm start

# Running on localhost:3000
```

## Installing a component

Also see [Loading a component](loading-a-component)

```
ruby scripts/component_manager.rb install user/repo [branch_name [commit_sha]]
ruby scripts/component_manager.rb export
```
*`branch_name` and `commit_sha` are optional. Default to master and last commit on branch.*

## Loading a component

In web/component-imports.js add the `component_name/html_file_name` to the imports array.
