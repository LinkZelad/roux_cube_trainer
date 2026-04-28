/// <reference types="vite/client" />

declare namespace JSX {
  interface IntrinsicElements {
    'twisty-player': React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement> & {
      alg?: string;
      puzzle?: string;
      background?: string;
      'control-panel'?: string;
      'hint-facelets'?: string;
      'back-view'?: string;
      'experimental-setup-alg'?: string;
      'experimental-setup-anchor'?: string;
    };
  }
}
