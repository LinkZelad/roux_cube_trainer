import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';
import { VitePWA } from 'vite-plugin-pwa';

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: 'autoUpdate',
      manifest: {
        name: 'Roux Bridge Trainer',
        short_name: 'Roux Trainer',
        description: 'Practice Roux first block and second block examples.',
        theme_color: '#181c23',
        background_color: '#181c23',
        display: 'standalone',
        start_url: '/'
      }
    })
  ],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: './src/test/setup.ts'
  }
});
