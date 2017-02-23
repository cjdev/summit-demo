#!/usr/bin/env racket
#lang scripty #:dependencies '("base" "aws-cloudformation-template-lib")
------------------------------------------------------------------------------------------------------
#lang aws/cloudformation/template
#:description "Deploy identity provider"

;; ---------------------------------------------------------------------------------------------------
;; params

(defparam name : String
  #:description "The first bit of our url"
  #:min-length 1)

;; ---------------------------------------------------------------------------------------------------
;; resources

(defresource bucket
  (aws:s3:bucket
   #:website-configuration { #:index-document "index.html" }
   #:access-control "PublicRead"
   #:bucket-name "!Sub ${name}.d.cjpowered.com"))


