;Fact base for numbers and letters
(deffacts letters-and-digits
    (letter E)
    (letter O)
    (letter W)
    (letter H)
    (letter N)
    (digit 1)
    (digit 2)
    (digit 3)
    (digit 4)
    (digit 5)
    (digit 6))

;Define the replacements
(defrule all-replacements
    (letter ?letter)
    (digit ?digit)
    =>
    (assert (replace ?letter ?digit)))

;Do forward checking
(defrule forward-checking
;checking the 1’s place
    (replace E ?e)
    (replace O ?o&~?e)
    (test (= (mod (+ ?e ?e) 10) ?o))
;checking up to 10’s place
    (replace W ?w&~?e&~?o)
    (replace H ?h&~?e&~?o&~?w)
    (replace N ?n&~?e&~?o&~?w&~?h)
    (test (= (+ ?e ?e (* ?w 10) (* ?h 10)) (+ ?o (* ?n 10))))
    =>
;display all solutions
    (printout t "W=" ?w ", O=" ?o ", H=" ?h ", E=" ?e ", O=" ?o crlf)
    (printout t " " ?w ?e crlf)
    (printout t " + " ?h ?e crlf)
    (printout t " ------" crlf)
    (printout t " " ?n ?o crlf crlf))