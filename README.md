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
node server

# Running on localhost:3000
```

## Adding a component

Also see [Loading a component](loading-a-component)

```
cd web/components
git clone git@github.com:user/repo.git
cd ../..
ruby scripts/component_manager.rb export
```

## Loading a component

In web/component-imports.js add the `component_name/html_file_name` to the imports array.
