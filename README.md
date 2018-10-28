- [Setting up a React project](#orga9a7ff2)



<a id="orga9a7ff2"></a>

# Setting up a React project

Initializing the NPM project

```shell
npm init --yes
```

Install React.

```shell
npm install react react-dom
```

Install webpack.

```shell
npm install -D webpack webpack-dev-server webpack-cli
```

```shell
mkdir -p public
touch public/index.html
```

Create an `index.html` file.

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8"/>
    <title>Document</title>
  </head>
  <body>
    <div id="root"></div>
    <script src="main.js" type="text/javascript"></script>
  </body>
</html>
```

Add a NPM start script.

```shell
cat package.json | jq .scripts
```

```org
{
  "start": "webpack-dev-server",
  "test": "echo \"Error: no test specified\" && exit 1"
}
```

Install `babel`.

```shell
npm install -D @babel/core @babel/preset-react
```

Configure `webpack` to use babel.

```shell
cat webpack.config.js
```

```org
const path = require('path');

const config = {
  entry: ['./src/index.js'],

  module: {
    rules: [
      {
	test: /\.jsx?/,
	loaders: ['babel-loader'],
	exclude: /node_modules/,
      },
    ],
  },
};

module.exports = config;
```

Install the `babel-loader` webpack plugin.

```shell
npm install -D babel-loader
```

Add babel configuration to `package.json`.

```shell
cat package.json | jq .babel
```

```org
{
  "presets": [
    "@babel/preset-react"
  ]
}
```

Load the `index.html` page.

```shell
npm install -D html-webpack-plugin
```

Add the plugin to the `webpack.config.js` file.

```javascript
{
  //...
  plugins: [
    new HtmlWebpackPlugin({
      template: './public/index.html',
      filename: './index.html',
    }),
  ]
}
```

Handle CSS with `post-css`.

```shell
npm install -D \
    style-loader \
    css-loader \
    precss \
    postcss-loader
```

Add a rule in `webpack.config.js` for handling CSS files.

```shell
node -p "
  require('./webpack.config.js')
    .module
    .rules
    .find((r) => r.test.exec('is.css'))
"
```

```org
{ test: /\.css$/,
  use:
   [ 'style-loader',
     { loader: 'css-loader', options: [Object] },
     'postcss-loader' ] }
```

And setup postcss in `package.json`.

```shell
cat package.json | jq .postcss
```

```org
{
  "map": false,
  "plugins": {
    "postcss-import": {},
    "postcss-preset-env": {
      "stage": 3
    }
  }
}
```

Now we install the postcss plugins.

```shell
npm install -D postcss-import postcss-preset-env
```

Now we setup a eslint configuration.

```shell
npm install -D eslint
```

```shell
cat .eslintrc.json
```

```org
{
  "env": {
    "browser": true,
    "es6": true
  },
  "extends": "eslint:recommended",
  "parserOptions": {
    "ecmaFeatures": {
      "jsx": true
    },
    "ecmaVersion": 2018,
    "sourceType": "module"
  },
  "plugins": [
    "react"
  ],
  "rules": {
    "indent": [
      "error",
      2
    ],
    "linebreak-style": [
      "error",
      "unix"
    ],
    "quotes": [
      "error",
      "single"
    ],
    "semi": [
      "error",
      "always"
    ]
  }
}
```

And prettier.

```shell
npm install -D prettier
```

```shell
cat .prettierrc
```

```org
{
  "tabWidth": 2,
  "singleQuote": true,
  "printWidth": 100,
  "trailingComma": "es5",
  "semi": true,
  "arrowParens": "always"
}
```
