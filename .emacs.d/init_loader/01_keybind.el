;; ----------------------------------------
;; key bind
;; 確認: describe-bindings, describe-key
;; ----------------------------------------
;; \C-z  suspend-frame => undo (取り消し)
(global-set-key "\C-z" 'undo)
;; \C-h help-command => delete-backward-char (カーソル前の一文字を消す)
(global-set-key "\C-h" 'delete-backward-char)
;; \C-w kill-region => scroll-down-command (上へ画面スクロール)
(global-set-key "\C-w" 'scroll-down-command)
;; \C-c\C-g undefined => goto-line (指定行へ移動)
(global-set-key "\C-c\C-g" 'goto-line)
;; \C-cw undefined => copy-region-as-kill (選択範囲をコピー)
(global-set-key "\C-cw" 'copy-region-as-kill)
;; \C-q quoted-insert => prefix key
(define-key global-map "\C-q" (make-sparse-keymap))

;; ----------------------------------------
;; window resizer
;; ---------------------------------------- 
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (let ((last-command-char (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))
(global-set-key "\C-q\C-r" 'window-resizer)