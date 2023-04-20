const { config, environment, Environment } = require('@rails/webpacker');
const erb = require('./loaders/erb')
const webpack = require('webpack')
const { resolve } = require('path');
const WebpackerPwa = require('webpacker-pwa');

environment.plugins.append('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery'
    })
)

environment.loaders.prepend('erb', erb)
new WebpackerPwa(config, environment);
module.exports = environment;