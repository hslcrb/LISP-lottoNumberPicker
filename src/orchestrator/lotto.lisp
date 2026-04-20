#!/usr/bin/sbcl --script
;; src/orchestrator/lotto.lisp
;; PolyLotto 오케스트레이터: C, C++, FORTRAN, COBOL 모듈을 유기적으로 연결합니다.

(setf *random-state* (make-random-state t))

(defun run-module (cmd &optional input)
  "외부 바이너리를 실행하고 결과를 반환합니다."
  (let ((process (sb-ext:run-program "/bin/sh" 
                                     (list "-c" cmd)
                                     :input (if input (make-string-input-stream input) nil)
                                     :output :stream
                                     :wait t)))
    (with-output-to-string (out)
      (loop for line = (read-line (sb-ext:process-output process) nil)
            while line do (format out "~A~%" line)))))

(defun main ()
  (let* ((args (cdr sb-ext:*posix-argv*))
         (count 1)
         (format "text")
         (interactive nil))
    
    ;; 인수 파싱
    (loop while args do
      (let ((arg (pop args)))
        (cond
          ((member arg '("-h" "--help") :test #'string=)
           (format t "PolyLotto 유기적 엔진~%사용법: ./lotto.lisp [옵션]~%")
           (format t "옵션: -c [수], --json, --xml, -i (대화형)~%")
           (sb-ext:exit))
          ((member arg '("-i" "--interactive") :test #'string=) (setf interactive t))
          ((member arg '("-c" "--count") :test #'string=) (setf count (parse-integer (pop args))))
          ((string= arg "--json") (setf format "json"))
          ((string= arg "--xml") (setf format "xml"))
          ((parse-integer arg :junk-allowed t) (setf count (parse-integer arg))))))

    (when interactive
      (format t "--- 🧬 PolyLotto 유기적 시스템 🧬 ---~%")
      (format t "몇 게임을 생성할까요?: ") (finish-output)
      (setf count (parse-integer (read-line))))

    ;; 1. C Core (Heart): 난수 생성
    (let* ((raw-numbers (run-module (format nil "./bin/lotto-core ~D" count)))
           (engine-cmd (format nil "./bin/lotto-engine --~A" format)))
      
      (format t "~%[Step 1] C Core에서 데이터 생성 완료 (Entropy Stream)~%")
      
      ;; 2. C++ Engine (Body): 필터링 및 포맷팅 (JSON/XML)
      (let ((formatted-output (run-module engine-cmd raw-numbers)))
        (format t "[Step 2] C++ Engine에서 ~A 형식으로 변환 완료~%" (string-upcase format))
        (format t "-------------------------------------------~%")
        (format t "~A" formatted-output)
        (format t "-------------------------------------------~%")
        
        ;; 3. FORTRAN Stats (Mind): 통계 분석
        (format t "~%[Step 3] FORTRAN Stats 모듈을 통한 수치 분석 결과:~%")
        (format t "~A" (run-module "./bin/lotto-stats" raw-numbers))
        
        ;; 4. COBOL Reporter (Voice): 공식 비즈니스 보고서
        (format t "~%[Step 4] COBOL Reporter가 생성한 공식 문서:~%")
        (format t "~A" (run-module "./bin/lotto-reporter" raw-numbers))))))

(main)
