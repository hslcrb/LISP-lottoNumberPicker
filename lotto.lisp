#!/usr/bin/sbcl --script
;; lotto.lisp
;; 고급 CLI 로또 번호 추첨기 (고정수, 제외수, 색상 출력, 파일 저장, 시뮬레이션 지원)

(setf *random-state* (make-random-state t))

;; --- ANSI 색상 상수 ---
(defparameter *color-reset*  (format nil "~C[0m" #\Esc))
(defparameter *color-yellow* (format nil "~C[33m" #\Esc)) ; 1-10
(defparameter *color-blue*   (format nil "~C[34m" #\Esc)) ; 11-20
(defparameter *color-red*    (format nil "~C[31m" #\Esc)) ; 21-30
(defparameter *color-gray*   (format nil "~C[90m" #\Esc)) ; 31-40
(defparameter *color-green*  (format nil "~C[32m" #\Esc)) ; 41-45
(defparameter *color-bold*   (format nil "~C[1m" #\Esc))

(defun get-color-for-num (num)
  "번호 대역에 따른 색상 코드를 반환합니다."
  (cond ((<= num 10) *color-yellow*)
        ((<= num 20) *color-blue*)
        ((<= num 30) *color-red*)
        ((<= num 40) *color-gray*)
        (t           *color-green*)))

(defun format-num-with-color (num)
  "숫자에 색상을 입혀 문자열로 변환합니다."
  (format nil "~A~2,'0D~A" (get-color-for-num num) num *color-reset*))

;; --- 유틸리티 ---

(defun split-str (str separator)
  "문자열을 구분자로 분리합니다."
  (let ((result '())
        (last 0))
    (loop for i from 0 below (length str) do
          (when (char= (char str i) separator)
            (push (subseq str last i) result)
            (setf last (1+ i))))
    (push (subseq str last) result)
    (nreverse result)))

(defun split-by-comma (str)
  "쉼표 또는 공백으로 된 문자열을 숫자 리스트로 변환합니다."
  (when (and str (not (string= str "")))
    (let* ((p1 (split-str str #\,))
           (parts (loop for p in p1 append (split-str p #\Space))))
      (mapcar #'parse-integer 
              (remove-if (lambda (s) 
                           (or (string= s "") 
                               (not (every #'digit-char-p s))))
                         parts)))))

;; --- 코어 로직 ---

(defun generate-lotto (&key fixed exclude)
  "지정된 고정수와 제외수를 고려하여 6개의 번호를 생성합니다."
  (let ((nums (copy-list fixed))
        (pool '()))
    (loop for i from 1 to 45 do
          (unless (member i (append fixed exclude))
            (push i pool)))
    (loop while (< (length nums) 6) do
          (let ((picked (nth (random (length pool)) pool)))
            (setf pool (remove picked pool))
            (push picked nums)))
    (sort nums #'<)))

(defun check-rank (picked winning)
  (let ((matches (length (intersection picked winning))))
    (cond ((= matches 6) "1등! 🎉")
          ((= matches 5) "3등!")
          ((= matches 4) "4등")
          ((= matches 3) "5등")
          (t "꽝"))))

;; --- 메인 인터페이스 ---

(defun print-help ()
  (format t "사용법: ./lotto.lisp [옵션]~%~%")
  (format t "옵션:~%")
  (format t "  -c, --count N        게임 수~%")
  (format t "  -f, --fixed N,M...   고정수~%")
  (format t "  -e, --exclude N,M... 제외수~%")
  (format t "  -s, --save PATH      파일 저장~%")
  (format t "  -m, --simulate N,M.. 당첨 번호~%")
  (format t "  -i, --interactive    대화형 모드~%"))

(defun interactive-mode ()
  (format t "--- 🍀 대화형 로또 생성기 🍀 ---~%")
  (format t "몇 게임? (기본 1): ") (finish-output)
  (let ((count (or (parse-integer (read-line) :junk-allowed t) 1)))
    (format t "고정수 (쉼표 구분): ") (finish-output)
    (let ((fixed (split-by-comma (read-line))))
      (format t "제외수 (쉼표 구분): ") (finish-output)
      (let ((exclude (split-by-comma (read-line))))
        (list :count count :fixed fixed :exclude exclude)))))

(defun main ()
  (let ((args (cdr sb-ext:*posix-argv*))
        (count 1) (fixed '()) (exclude '()) (save-path nil) (winning nil) (interactive nil))
    
    (loop while args do
      (let ((arg (pop args)))
        (cond
          ((member arg '("-h" "--help") :test #'string=) (print-help) (sb-ext:exit))
          ((member arg '("-i" "--interactive") :test #'string=) (setf interactive t))
          ((member arg '("-c" "--count") :test #'string=) (setf count (parse-integer (pop args))))
          ((member arg '("-f" "--fixed") :test #'string=) (setf fixed (split-by-comma (pop args))))
          ((member arg '("-e" "--exclude") :test #'string=) (setf exclude (split-by-comma (pop args))))
          ((member arg '("-s" "--save") :test #'string=) (setf save-path (pop args)))
          ((member arg '("-m" "--simulate") :test #'string=) (setf winning (split-by-comma (pop args))))
          ((parse-integer arg :junk-allowed t) (setf count (parse-integer arg))))))

    (when (or interactive (and (not args) (= count 1) (null fixed) (null exclude) (null save-path) (null winning) (null (cdr sb-ext:*posix-argv*))))
      (let ((params (interactive-mode)))
        (setf count (getf params :count) fixed (getf params :fixed) exclude (getf params :exclude))))

    (let ((output '()))
      (format t "~%--- 🍀 로또 번호 추첨 (~D게임) ---~%" count)
      (dotimes (i count)
        (let* ((lotto (generate-lotto :fixed fixed :exclude exclude))
               (colored (format nil "[게임 ~D]  ~{~A ~}" (1+ i) (mapcar #'format-num-with-color lotto)))
               (plain (format nil "[게임 ~D]  ~{~2,'0D ~}" (1+ i) lotto)))
          (if winning
              (let ((rank (check-rank lotto winning)))
                (format t "~A (~A)~%" colored rank)
                (push (format nil "~A (~A)" plain rank) output))
              (progn
                (format t "~A~%" colored)
                (push plain output)))))
      
      (when save-path
        (with-open-file (s save-path :direction :output :if-exists :supersede :if-does-not-exist :create)
          (dolist (line (reverse output)) (write-line line s)))
        (format t "~%✅ ~A 에 저장 완료.~%" save-path)))))

(main)
