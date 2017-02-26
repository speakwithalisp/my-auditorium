(ns my-auditorium.routes.home
  (:require [my-auditorium.layout :as layout]
            [compojure.core :refer [defroutes GET POST]]
            [ring.util.http-response :as response]
            [my-auditorium.db.core :as db]
            [bouncer.core :as b]
            [bouncer.validators :as v]
            [clojure.java.io :as io]))

(defn validate-show [params]
  (first (
          b/validate
          params
          :show_name v/required)))

(defn validate-booking [params]
  (first (
          b/validate
          params
          :seat_id v/required
          )))
(defn book-ticket! [{:keys [params]}]
  (if-let [errors (validate-booking params)]
    (-> (response/found "/")
    (assoc :flash (assoc params :errors errors)))
    (do (db/book-ticket
         (assoc params :timestamp (java.util.Date.)))
        (response/found "/"))))
(defn save-show! [{:keys [params]}]
  (if-let [errors (validate-show params)]
    (-> (response/found "/admin")
    (assoc :flash (assoc params :errors errors)))
    (do (db/create-show!
         (assoc params :timestamp (java.util.Date.)))
        (response/found "/admin"))))
(defn delete-show! [{:keys [params]}]
  (do (db/delete-show params)
      (response/found "/admin"))
  )

(defn admin-page [{:keys [flash]}]
  (layout/render
   "admin.html"
   (merge {:shows (db/get-shows)}
(select-keys flash [:show_name :errors])
          )
   ))
(defn home-page [{:keys [flash]}]
  (layout/render "home.html"
                 (merge {:shows (db/get-shows)}
                        {:seats (db/get-seats)})
                 (select-keys flash [:seat_id :errors])))

(defn about-page []
  (layout/render "about.html"))

(defroutes home-routes
  (GET "/" request (home-page request))
  (POST "/" request (book-ticket! request))
  (GET "/admin" request (admin-page request))
  (POST "/admin" request (save-show! request))
  (POST "/admin/:id" request (delete-show! request))
  (GET "/about" [] (about-page)))

