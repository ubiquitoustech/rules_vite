import react from "@vitejs/plugin-react";
import mdx from "vite-plugin-mdx";
import ssr from "vite-plugin-ssr/plugin";
import { UserConfig } from "vite";

const config: UserConfig = {
  plugins: [react(), mdx(), ssr()],
  optimizeDeps: { include: ["@mdx-js/react"] },
  clearScreen: false,
  server: {
    port: 3001,
    hmr: {
      protocol: "ws",
      // timeout: 1,
      port: 3001,
      // host: 'localhost',
      // overlay: false,
    },
    // watch: {
    //   usePolling: false
    // }
  },
  resolve: {
    preserveSymlinks: true,
  },
  logLevel: "info",
  build: {
    rollupOptions: {
      // output: {
      //   dir: 'bazel-out/k8-fastbuild/bin',
      //   entryFileNames: `assets/[name].js`,
      //   chunkFileNames: `assets/[name].js`,
      //   assetFileNames: `assets/[name].[ext]`
      // }
    },
  },
};

export default config;
