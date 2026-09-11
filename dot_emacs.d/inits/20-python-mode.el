;;; 20-python-mode.el --- python mode config
;;; Commentary:
;;; Code:

(use-package smartrep)

(add-to-list 'major-mode-remap-defaults '(python-mode . python-ts-mode))

;; need install `pip install python-lsp-server python-lsp-ruff`'
;; need install `pipx install ruff'
(use-package python
  :ensure nil
  :interpreter ("python" . python-ts-mode)
  :hook
  ((python-ts-mode . eglot-ensure)
   (python-ts-mode . ruff-format-on-save-mode))
  :init
  (add-to-list 'eglot-server-programs '(python-ts-mode "pylsp")))

(use-package reformatter)
(use-package ruff-format
  :after reformatter
  :config
  (reformatter-define ruff-sort-imports
    :program "ruff"
    :args '("--fix" "--select" "I001")
    :group 'python)
  (add-hook 'python-ts-mode-hook #'ruff-sort-imports-on-save-mode))

(use-package flymake-ruff
  :hook (eglot-managed-mode-hook . (lambda ()
                                     (when (derived-mode-p 'python-mode 'python-ts-mode)
                                       (flymake-ruff-load))))
  :custom
  (flymake-ruff--default-configs '("ruff.toml" ".ruff.toml")))

;;; 20-python-mode.el ends here
