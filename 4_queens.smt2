; N-Queens Problem in SMT-LIB
; This encodes the problem of placing N queens on an NxN chessboard
; such that no two queens threaten each other.

(set-logic AUFLIA)

; Define the size of the board (N)
(declare-const N Int)

; Assert that N is greater than or equal to 4
(assert (= N 4))

; Declare an array to represent the positions of queens
; queens[i] = the column position of the queen in row i
(declare-fun queens (Int) Int)

; Ensure that all queens are placed within the board boundaries
(assert (forall ((i Int))
  (=> (and (>= i 0) (< i N))
    (and (>= (queens i) 0) (< (queens i) N)))))

; Ensure that no two queens are in the same column
(assert (forall ((i Int) (j Int))
  (=> (and (>= i 0) (< i N) (>= j 0) (< j N) (not (= i j)))
    (not (= (queens i) (queens j))))))

; Ensure that no two queens are on the same diagonal
(assert (forall ((i Int) (j Int))
  (=> (and (>= i 0) (< i N) (>= j 0) (< j N) (not (= i j)))
    (not (= (abs (- (queens i) (queens j))) (abs (- i j)))))))

; Check satisfiability
(check-sat)

; Get a model if satisfiable
(get-model)

; Retrieve the values of the queens array
(get-value ((queens 0) (queens 1) (queens 2) (queens 3)))