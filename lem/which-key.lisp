(defpackage :lem/which-key
  (:use :cl :lem)
  (:export :*which-key-delay*
           :*which-key-columns*
           :*which-key-gravity*))
(in-package :lem/which-key)

;;; --- Config ---

(defvar *which-key-delay* 400
  "Milliseconds to wait before showing which-key popup.")

(defvar *which-key-columns* 3
  "Number of columns in which-key popup.")

(defvar *which-key-gravity* :bottom-display
  "Popup position. :bottom-display (emacs), :center (snacks.nvim), :cursor (tooltip)")

;;; --- State ---

(defvar *which-key-popup* nil)
(defvar *which-key-timer* nil)

;;; --- Collect bindings under a prefix hash-table ---

(defun collect-prefix-bindings (prefix-table)
  "Walk a prefix hash-table and return ((key-string . command-name) ...).
     Only one level deep — sub-prefixes shown as '+prefix'."
  (let ((bindings '()))
    (maphash (lambda (key val)
               (cond ((lem-core::prefix-command-p val)
                      ;; Sub-prefix: show as group
                      (push (cons (format nil "~A" key) "+prefix") bindings))
                     ((and (symbolp val)
                           (not (equal "UNDEFINED-KEY" (symbol-name val))))
                      (push (cons (format nil "~A" key)
                                  (string-downcase (symbol-name val)))
                            bindings))))
             prefix-table)
    (sort bindings #'string< :key #'car)))

;;; --- Format bindings into columns ---

(defun format-bindings (bindings)
  "Format bindings into a multi-column string."
  (when (null bindings) (return-from format-bindings ""))
  (let* ((ncols *which-key-columns*)
         ;; Compute max key and command widths
         (max-key-w (loop :for (k . _) :in bindings :maximize (length k)))
         (max-cmd-w (min 30 (loop :for (_ . c) :in bindings :maximize (length c))))
         (col-w (+ max-key-w 3 max-cmd-w 2))  ;; "key → cmd  "
         (nrows (ceiling (length bindings) ncols)))
    (with-output-to-string (s)
      (dotimes (row nrows)
        (dotimes (col ncols)
          (let ((idx (+ row (* col nrows))))
            (when (< idx (length bindings))
              (destructuring-bind (key . cmd) (nth idx bindings)
                (format s "~vA → ~vA"
                        max-key-w key
                        (+ max-cmd-w 2) cmd)))))
        (terpri s)))))

;;; --- Show / dismiss popup ---

(defun show-which-key (prefix-table prefix-str)
  (dismiss-which-key)
  (let* ((bindings (collect-prefix-bindings prefix-table))
         (text (format nil " ~A …~%~A" prefix-str (format-bindings bindings))))
    (when bindings
      (setf *which-key-popup*
            (display-popup-message
             text
             :timeout nil
             :style (make-style :gravity *which-key-gravity*
                                :use-border t))))))

(defun dismiss-which-key ()
  (when *which-key-popup*
    (delete-popup-message *which-key-popup*)
    (setf *which-key-popup* nil)))

;;; --- Monkey-patch read-command ---

(defun lem-core::read-command ()
  (let ((event (lem-core::read-event)))
    (etypecase event
      (lem-core::mouse-event
       (lem-core::set-last-mouse-event event)
       (lem-core::find-mouse-command event))
      (key
       (let* ((cmd (lookup-keybind event))
              (kseq (list event)))
         (loop
           (cond ((lem-core::prefix-command-p cmd)
                  ;; --- which-key injection ---
                  (let ((prefix-str (keyseq-to-string kseq))
                        (prefix-table cmd))
                    ;; Start timer to show popup after delay
                    (setf *which-key-timer*
                          (start-timer
                           (make-idle-timer
                            (lambda ()
                              (show-which-key prefix-table prefix-str))
                            :name "which-key")
                           *which-key-delay*))
                    ;; Read next key (blocks)
                    (let ((next-event (read-key)))
                      ;; Cancel timer + dismiss popup
                      (when *which-key-timer*
                        (stop-timer *which-key-timer*)
                        (setf *which-key-timer* nil))
                      (dismiss-which-key)
                      ;; Normal flow
                      (setf kseq (nconc kseq (list next-event)))
                      (setf cmd (lookup-keybind kseq)))))
                 (t
                  (set-last-read-key-sequence kseq)
                  (return cmd))))))))) (defpackage :lem/which-key
                                         (:use :cl :lem)
                                         (:export :*which-key-delay*
                                                  :*which-key-columns*
                                                  :*which-key-gravity*))
(in-package :lem/which-key)

;;; --- Config ---

(defvar *which-key-delay* 400
  "Milliseconds to wait before showing which-key popup.")

(defvar *which-key-columns* 3
  "Number of columns in which-key popup.")

(defvar *which-key-gravity* :bottom-display
  "Popup position. :bottom-display (emacs), :center (snacks.nvim), :cursor (tooltip)")

;;; --- State ---

(defvar *which-key-popup* nil)
(defvar *which-key-timer* nil)

;;; --- Collect bindings under a prefix hash-table ---

(defun collect-prefix-bindings (prefix-table)
  "Walk a prefix hash-table and return ((key-string . command-name) ...).
     Only one level deep — sub-prefixes shown as '+prefix'."
  (let ((bindings '()))
    (maphash (lambda (key val)
               (cond ((lem-core::prefix-command-p val)
                      ;; Sub-prefix: show as group
                      (push (cons (format nil "~A" key) "+prefix") bindings))
                     ((and (symbolp val)
                           (not (equal "UNDEFINED-KEY" (symbol-name val))))
                      (push (cons (format nil "~A" key)
                                  (string-downcase (symbol-name val)))
                            bindings))))
             prefix-table)
    (sort bindings #'string< :key #'car)))

;;; --- Format bindings into columns ---

(defun format-bindings (bindings)
  "Format bindings into a multi-column string."
  (when (null bindings) (return-from format-bindings ""))
  (let* ((ncols *which-key-columns*)
         ;; Compute max key and command widths
         (max-key-w (loop :for (k . _) :in bindings :maximize (length k)))
         (max-cmd-w (min 30 (loop :for (_ . c) :in bindings :maximize (length c))))
         (col-w (+ max-key-w 3 max-cmd-w 2))  ;; "key → cmd  "
         (nrows (ceiling (length bindings) ncols)))
    (with-output-to-string (s)
      (dotimes (row nrows)
        (dotimes (col ncols)
          (let ((idx (+ row (* col nrows))))
            (when (< idx (length bindings))
              (destructuring-bind (key . cmd) (nth idx bindings)
                (format s "~vA → ~vA"
                        max-key-w key
                        (+ max-cmd-w 2) cmd)))))
        (terpri s)))))

;;; --- Show / dismiss popup ---

(defun show-which-key (prefix-table prefix-str)
  (dismiss-which-key)
  (let* ((bindings (collect-prefix-bindings prefix-table))
         (text (format nil " ~A …~%~A" prefix-str (format-bindings bindings))))
    (when bindings
      (setf *which-key-popup*
            (display-popup-message
             text
             :timeout nil
             :style (make-style :gravity *which-key-gravity*
                                :use-border t))))))

(defun dismiss-which-key ()
  (when *which-key-popup*
    (delete-popup-message *which-key-popup*)
    (setf *which-key-popup* nil)))

;;; --- Monkey-patch read-command ---

(defun lem-core::read-command ()
  (let ((event (lem-core::read-event)))
    (etypecase event
      (lem-core::mouse-event
       (lem-core::set-last-mouse-event event)
       (lem-core::find-mouse-command event))
      (key
       (let* ((cmd (lookup-keybind event))
              (kseq (list event)))
         (loop
           (cond ((lem-core::prefix-command-p cmd)
                  ;; --- which-key injection ---
                  (let ((prefix-str (keyseq-to-string kseq))
                        (prefix-table cmd))
                    ;; Start timer to show popup after delay
                    (setf *which-key-timer*
                          (start-timer
                           (make-idle-timer
                            (lambda ()
                              (show-which-key prefix-table prefix-str))
                            :name "which-key")
                           *which-key-delay*))
                    ;; Read next key (blocks)
                    (let ((next-event (read-key)))
                      ;; Cancel timer + dismiss popup
                      (when *which-key-timer*
                        (stop-timer *which-key-timer*)
                        (setf *which-key-timer* nil))
                      (dismiss-which-key)
                      ;; Normal flow
                      (setf kseq (nconc kseq (list next-event)))
                      (setf cmd (lookup-keybind kseq)))))
                 (t
                  (set-last-read-key-sequence kseq)
                  (return cmd)))))))))