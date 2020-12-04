const path = require('path')

module.exports = {
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
      },
    ],
  },
  resolve: {
    alias: {
      '@': path.join(__dirname, 'src'),
      '@tests': path.join(__dirname, 'tests'),
      vue$: 'vue/dist/vue.esm.js',
    },
    extensions: ['.ts', '.js'],
  },
}
