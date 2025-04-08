; User Access Policy in SMT-LIB with integer roles

; Declare sorts for users and resources
(declare-sort User 0)
(declare-sort Resource 0)

; Declare functions for user roles and resource permissions
(declare-fun userRole (User) Int) ; User's role is now directly an integer
(declare-fun canAccess (User Resource) Bool)
(declare-fun requiresRole (Resource) Int) ; Resource's required role is an integer

; Define a safety property: A user can access a resource only if their role is sufficient
(assert (forall ((u User) (r Resource))
    (=> (canAccess u r)
        (>= (userRole u) (requiresRole r)))))

; Add some example constraints
(declare-const alice User)
(declare-const bob User)
(declare-const file1 Resource)

; Example roles and permissions
(assert (= (userRole alice) 10)) ; Alice has a role level of 10
(assert (= (userRole bob) 5))    ; Bob has a role level of 5
(assert (= (requiresRole file1) 10)) ; file1 requires a role level of 10

; Assert that Bob cannot access file1 (safety check)
(assert (canAccess bob file1))

; Check if the policy is safe
(check-sat)