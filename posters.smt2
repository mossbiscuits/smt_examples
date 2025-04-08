; SMT-LIB specification for rectangle fitting (poster printing problem)

(set-logic AUFLIA)

; Dimensions of the poster
(declare-const poster_width Int)
(declare-const poster_height Int)

; Number of rectangles to fit
(declare-const num_rectangles Int)

; Dimensions of each rectangle
(declare-fun rect_width (Int) Int)
(declare-fun rect_height (Int) Int)

; Position of each rectangle on the poster
(declare-fun rect_x (Int) Int)
(declare-fun rect_y (Int) Int)

; Ensure all rectangles fit within the poster boundaries
(assert (forall ((i Int))
    (=> (and (>= i 0) (< i num_rectangles))
        (and (>= (rect_x i) 0)
             (>= (rect_y i) 0)
             (<= (+ (rect_x i) (rect_width i)) poster_width)
             (<= (+ (rect_y i) (rect_height i)) poster_height)))))

; Ensure no two rectangles overlap
(assert (forall ((i Int) (j Int))
    (=> (and (>= i 0) (< i num_rectangles) (>= j 0) (< j num_rectangles) (not (= i j)))
        (or (<= (+ (rect_x i) (rect_width i)) (rect_x j))
            (<= (+ (rect_x j) (rect_width j)) (rect_x i))
            (<= (+ (rect_y i) (rect_height i)) (rect_y j))
            (<= (+ (rect_y j) (rect_height j)) (rect_y i))))))

; Example: Set poster dimensions and number of rectangles
(assert (= poster_width 100))
(assert (= poster_height 200))
(assert (= num_rectangles 3))

; Example: Set dimensions of rectangles
(assert (= (rect_width 0) 30))
(assert (= (rect_height 0) 40))
(assert (= (rect_width 1) 50))
(assert (= (rect_height 1) 60))
(assert (= (rect_width 2) 20))
(assert (= (rect_height 2) 30))

; Check satisfiability
(check-sat)

; Get values for poster dimensions
(get-value (poster_width poster_height))

; Get the number of rectangles
(get-value (num_rectangles))

; Get dimensions and positions of each rectangle
(get-value ((rect_width 0) (rect_height 0) (rect_x 0) (rect_y 0)))
(get-value ((rect_width 1) (rect_height 1) (rect_x 1) (rect_y 1)))
(get-value ((rect_width 2) (rect_height 2) (rect_x 2) (rect_y 2)))