const path = require('path');
const upstream_default = require('./webpack.prod');
const { merge } = require('webpack-merge');
const WorkboxPlugin = require('workbox-webpack-plugin');

module.exports = merge({
    // output: { publicPath: '../build/' },
    optimization: { minimize: false }
}, upstream_default);
