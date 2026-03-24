;; -*- no-byte-compile: t; -*-
;;; packages.el

(package! evil-escape :disable t)

(package! dotenv-mode)

(package! eat)
;; update pin: curl -s "https://api.github.com/repos/cpoile/claudemacs/commits/main" | grep '"sha"' | head -1 | cut -d'"' -f4
(package! claudemacs
  :recipe (:host github :repo "cpoile/claudemacs")
  :pin "41c5da556548e220f641fae994bc5110e8c65858")

(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))
