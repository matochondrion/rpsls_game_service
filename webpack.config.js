const webpack = require("webpack");
const path = require("path");

module.exports = {
  entry: ["./src/index"],
  module: {
    loaders: [
      { test: /\.js?$/, loader: "babel-loader", exclude: /node_modules/ },
      { test: /\.s?css$/, loader: "style-loader!css-loader!sass-loader" }
    ]
  },
  resolve: {
    extensions: [".js", ".scss"]
  },
  output: {
    path: path.join(__dirname, "/lib/app/public"),
    filename: "bundle.js"
  },
  devtool: "cheap-eval-source-map",
  devServer: {
    contentBase: "./lib/app/views/",
    hot: true,
    proxy: {
      "/api": "http://54.70.36.146:4567"
    }
  },
  plugins: [
    new webpack.optimize.OccurrenceOrderPlugin(),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoEmitOnErrorsPlugin()
  ]
};
