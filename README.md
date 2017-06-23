# Web Components Playground

Playing around with web components.

## Requirements:

- node
- bower (ugh...)
- ruby (for setup)

## Setup

```
git clone git@github.com:jphager2/webcomponents-playground
cd webcomponents-playground
bower install
ln -s bower_components web/components
```

## Running the server

```
npm start

# Running on localhost:3000
```

## Installing a component

Also see [Loading a component](loading-a-component)

```
bower install --save [component-package]
```

## Loading a component

In web/component-imports.js add the `component_name/html_file_name` to the bowerImports array.
