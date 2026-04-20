#!/usr/bin/sbcl --script
;; lotto.lisp
;; CLI 로또 번호 추첨기

;; 랜덤 시드를 현재 시간에 맞춰 초기화합니다.
(setf *random-state* (make-random-state t))

(defun generate-lotto ()
  "1부터 45까지의 숫자 중 중복되지 않는 6개의 숫자를 뽑아 정렬합니다."
  (let ((nums '()))
    (loop while (< (length nums) 6) do
      (pushnew (1+ (random 45)) nums))
    (sort (copy-list nums) #'<)))

(defun print-lotto-sets (count)
  "지정된 게임 수만큼 로또 번호를 출력합니다."
  (format t "~%--- 🍀 로또 번호 추첨 (총 ~D게임) 🍀 ---~%" count)
  (dotimes (i count)
    ;; ~{~2,'0D ~} 를 통해 1자리 숫자는 앞에 0을 붙여 출력하도록 포맷팅합니다.
    (format t "[게임 ~D]  ~{~2,'0D ~}~%" (1+ i) (generate-lotto)))
  (format t "-------------------------------------------~%~%"))

(defun main ()
  "명령줄 인수를 파싱하여 로또 게임 수를 결정하고 실행합니다."
  (let* ((all-args #+sbcl sb-ext:*posix-argv*
                   #+clisp ext:*args*
                   #+ecl (ext:command-args)
                   #+ccl ccl:*command-line-argument-list*
                   #-(or sbcl clisp ecl ccl) nil)
         ;; 스크립트로 실행할 경우 첫 번째 인수는 스크립트 이름이므로 제외합니다.
         (args (cdr all-args))
         (count 1))
    
    (cond
      ((member "-h" args :test #'string=)
       (format t "사용법: ./lotto.lisp [게임_수]~%예: ./lotto.lisp 5 (5게임 생성)~%"))
      ((member "--help" args :test #'string=)
       (format t "사용법: ./lotto.lisp [게임_수]~%예: ./lotto.lisp 5 (5게임 생성)~%"))
      (t
       (loop for arg in args do
             (let ((parsed (parse-integer arg :junk-allowed t)))
               (when (and parsed (> parsed 0))
                 (setf count parsed))))
       (print-lotto-sets count)))))

;; 실행
(main)
