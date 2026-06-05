const path = require('path');

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'images.unsplash.com'
      }
    ]
  },
  webpack(config) {
    config.resolve.alias = {
      ...config.resolve.alias,
      '@aura/core': path.resolve(__dirname, '../../packages/core/src'),
      '@aura/ui': path.resolve(__dirname, '../../packages/ui/src'),
      '@aura/api': path.resolve(__dirname, '../../packages/api/src')
    };
    return config;
  }
};

module.exports = nextConfig;
