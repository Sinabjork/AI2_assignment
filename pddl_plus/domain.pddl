(define (domain sar-plus)
  (:requirements :strips :typing :fluents :negative-preconditions)

  ; TYPES
  (:types robot location victim diagnosis treatment)

  ; PREDICATES
  (:predicates
    (at ?r - robot ?l - location)
    (victim-at ?v - victim ?l - location)
    (connected ?a - location ?b - location)
    (evacuation-point ?l - location)

    (diagnosed ?v - victim)
    (stabilized ?v - victim)
    (evacuated ?v - victim)
    (health-failure ?v - victim)

    (has-diagnosis ?v - victim ?d - diagnosis)
    (needs-treatment ?d - diagnosis ?t - treatment)

    (moving ?r - robot ?from - location ?to - location)
    (stabilizing ?r - robot ?v - victim)
    (busy ?r - robot)
  )

  ; FUNCTIONS
  (:functions
    (health ?v - victim)
    (worsening-rate ?v - victim)

    (distance ?a - location ?b - location)

    (move-progress ?r - robot)
    (stabilization-progress ?v - victim)
  )

  ; HEALTH DECAY
  (:process health-decay
    :parameters (?v - victim)
    :precondition (and
      (not (stabilized ?v))
      (not (health-failure ?v))
    )
    :effect
      (decrease (health ?v) (* #t (worsening-rate ?v)))
  )

  ; HEALTH FAILURE
  (:event victim-health-failure
    :parameters (?v - victim)
    :precondition (and
      (<= (health ?v) 0)
      (not (health-failure ?v))
    )
    :effect (health-failure ?v)
  )

  ; MOVEMENT
  (:action start-move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and
      (at ?r ?from)
      (connected ?from ?to)
      (not (busy ?r))
    )
    :effect (and
      (not (at ?r ?from))
      (moving ?r ?from ?to)
      (busy ?r)
      (assign (move-progress ?r) 0)
    )
  )

  (:process moving-process
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (moving ?r ?from ?to)
    :effect
      (increase (move-progress ?r) (* #t 1))
  )

  (:event finish-move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and
      (moving ?r ?from ?to)
      (>= (move-progress ?r) (distance ?from ?to))
    )
    :effect (and
      (not (moving ?r ?from ?to))
      (not (busy ?r))
      (at ?r ?to)
    )
  )

  ; DIAGNOSE
  (:action diagnose
    :parameters (?r - robot ?v - victim ?l - location ?d - diagnosis)
    :precondition (and
      (at ?r ?l) 
      (victim-at ?v ?l) 
      (has-diagnosis ?v ?d)
      (not (health-failure ?v)) 
      (not (diagnosed ?v))
    )
    :effect (and
      (diagnosed ?v)
      (decrease (health ?v) (* 1 (worsening-rate ?v))) 
    )
  )

  ; STABILIZE
  (:action start-stabilize
    :parameters (?r - robot ?v - victim ?l - location ?d - diagnosis ?t - treatment)
    :precondition (and
      (at ?r ?l)
      (victim-at ?v ?l)
      (diagnosed ?v)
      (has-diagnosis ?v ?d)
      (needs-treatment ?d ?t)
      (not (busy ?r))
      (not (stabilized ?v))
      (not (health-failure ?v))
    )
    :effect (and
      (stabilizing ?r ?v)
      (busy ?r)
      (assign (stabilization-progress ?v) 0)
    )
  )

  (:process stabilization-process
    :parameters (?r - robot ?v - victim)
    :precondition (stabilizing ?r ?v)
    :effect
      (increase (stabilization-progress ?v) (* #t 1))
  )

  (:event finish-stabilize
    :parameters (?r - robot ?v - victim)
    :precondition (and
      (stabilizing ?r ?v)
      (>= (stabilization-progress ?v) 5)
      (not (health-failure ?v))
    )
    :effect (and
      (not (stabilizing ?r ?v))
      (not (busy ?r))
      (stabilized ?v)
    )
  )

  ; TRANSPORT
  (:action transport
    :parameters (?r - robot ?v - victim ?from - location ?to - location)
    :precondition (and
      (at ?r ?from) (victim-at ?v ?from) (stabilized ?v) 
      (connected ?from ?to) (evacuation-point ?to)
    )
    :effect (and
      (not (at ?r ?from)) (not (victim-at ?v ?from))
      (at ?r ?to) (victim-at ?v ?to) (evacuated ?v)
    )
  )
)