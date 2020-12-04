module.exports = {
  // devServerの設定
  devServer: {
    watchOptions: {
      poll: 1000,
    },
    proxy: {
      '/google-api': {
        target: 'https://maps.googleapis.com/',
        pathRewrite: { '^/google-api': '' },
      },
      '/api': {
        target: process.env.GEOLOGIC_API_URL,
        pathRewrite: {
          '^/api': '',
        },
      },
    },
  },
  // webpackの設定
  configureWebpack: require('./webpack.config.js'),
}
