import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3001, // Porta alternativa (para não conflitar)
    host: '0.0.0.0',
  },
});
