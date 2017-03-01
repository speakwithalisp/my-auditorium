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
    (-> (response/found (str "/show/" (:show_id params)))
    (assoc :flash (assoc params :errors errors)))
    (do (db/book-ticket
         (assoc params :timestamp (java.util.Date.)))
        (assoc (response/found (str "/show/" (:show_id params))) :flash (assoc params :success (str "Congratulations! You have booked this seat!")) ))))

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
(select-keys flash [:show_name :errors :success])
          )
   ))

(defn home-page [{:keys [flash]}]
  (layout/render "home.html"
                 (merge {:shows (db/get-shows)})))

(defn about-page []
  (layout/render "about.html"))

(defn show-page [{:keys [params flash]}]
  (layout/render "show.html"
                 (merge {:available_seats (db/get-available-seats {:id (:show_id params)})}
                        {:seats (db/get-seats)}
                        {:show_id (:show_id params)}
                        {:show (db/get-show {:id  (:show_id params)})}
                        (select-keys flash [:seat_id :errors :success]))))

(defroutes home-routes
  (GET "/" request (home-page request))
  (GET "/show/:show_id" request (show-page request))
  (POST "/show/:show_id" request (book-ticket! request))
  (GET "/admin" request (admin-page request))
  (POST "/admin" request (save-show! request))
  (POST "/admin/:id" request (delete-show! request))
  (GET "/about" [] (about-page)))

