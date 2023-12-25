/// <reference types="vite/client" />
declare module '*.vue' {
    import { App, defineComponent } from 'vue'
    const component: ReturnType<typeof defineComponent> & {
        install(app: App): void
    }
    export default component
}
declare module '*.js' {
    const config: any; // 或其他具体的类型定义
    export default config;
}