(define (domain search-and-rescue)
  (:requirements 
    :strips 
    :typing
  )

  ; TYPES
  (:types robot location victim diagnosis treatment health-level)

  ; PREDICATES
  (:predicates
    (at ?r - robot ?l - location)
    (victim-at ?v - victim ?l - location)
    (connected ?from - location ?to - location)
    (evacuation-point ?l - location)
    
    (victim-health ?v - victim ?h - health-level)
    (next-health-level ?current - health-level ?next - health-level)
    (is-stabilized ?h - health-level)
    
    (has-diagnosis ?v - victim ?d - diagnosis)
    (needs-treatment ?d - diagnosis ?t - treatment)
    (diagnosed ?v - victim)
  )

  ; MOVEMENT
  (:action move
    :parameters 
        (?r - robot ?from - location ?to - location)
    :precondition (and 
        (at ?r ?from) 
        (connected ?from ?to)
    )
    :effect (and 
        (not (at ?r ?from)) 
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
        )
    :effect (and (diagnosed ?v))
  )

  ; STABILIZE
  (:action stabilize
    :parameters (?r - robot ?v - victim ?l - location ?d - diagnosis ?t - treatment ?current - health-level ?better - health-level)
    :precondition (and 
        (at ?r ?l) 
        (victim-at ?v ?l) 
        (diagnosed ?v) 
        (has-diagnosis ?v ?d) 
        (needs-treatment ?d ?t)
        (victim-health ?v ?current)
        (next-health-level ?current ?better)
    )
    :effect (and 
        (not (victim-health ?v ?current))
        (victim-health ?v ?better)
    )
  )

  ; TRANSPORT
  (:action transport
    :parameters (?r - robot ?v - victim ?from - location ?to - location ?h - health-level)
    :precondition (and 
        (at ?r ?from) 
        (victim-at ?v ?from)
        (connected ?from ?to) 
        (evacuation-point ?to)
        (victim-health ?v ?h)
        (is-stabilized ?h) 
    )
    :effect (and 
        (not (victim-at ?v ?from)) 
        (victim-at ?v ?to)
        (not (at ?r ?from)) 
        (at ?r ?to)
    )
  )
)