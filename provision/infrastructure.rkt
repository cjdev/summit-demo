#!/usr/bin/env racket
#lang scripty #:dependencies '("base" "aws-cloudformation-template-lib")
------------------------------------------------------------------------------------------------------
#lang aws/cloudformation/template
#:description "Deploy identity provider"

;; ---------------------------------------------------------------------------------------------------
;; params

(defparam name : String
  #:description "The first bit of our url"
  #:min-length 1
  #:default "summit-demo")

;; ---------------------------------------------------------------------------------------------------
;; resources

(defresource bucket
  (aws:s3:bucket
   #:website-configuration { #:index-document "index.html" }
   #:bucket-name (fn:join [name ".d.cjpowered.com"])))

(defresource domain
  (aws:route53:record-set
   #:name (fn:join [name ".d.cjpowered.com."])
   #:type "CNAME"
   #:hosted-zone-name "d.cjpowered.com."
   #:resource-records [(fn:get-att bucket "DomainName")]
   #:ttl "300"))

#;(defresource bucket-policy
  (aws:s3:bucket-policy
   #:bucket bucket
   #:policy-document (dict #:version "2012-10-17"
                           #:statement [(dict #:sid "AddPerm"
                                              #:effect "Allow"
                                              #:principal "*"
                                              #:action ["s3::GetObject"]
                                              #:resource [(fn:join ["arn:aws:s3::"(fn:get-att bucket "DomainName")])])])))


