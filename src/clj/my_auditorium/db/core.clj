(ns my-auditorium.db.core
  (:require
    [clojure.java.jdbc :as jdbc]
    [conman.core :as conman]
    [my-auditorium.config :refer [env]]
    [mount.core :refer [defstate]])
  (:import [java.sql
            BatchUpdateException
            PreparedStatement]))

(defstate ^:dynamic *db*
           :start (conman/connect! {:jdbc-url (env :database-url)})
           :stop (conman/disconnect! *db*))

(conman/bind-connection *db* "sql/queries.sql")

(defn to-date [^java.sql.Date sql-date]
  (-> sql-date (.getTime) (java.util.Date.)))

(extend-protocol jdbc/IResultSetReadColumn
  java.sql.Date
  (result-set-read-column [v _ _] (to-date v))

  java.sql.Timestamp
  (result-set-read-column [v _ _] (to-date v)))

(extend-type java.util.Date
  jdbc/ISQLParameter
  (set-parameter [v ^PreparedStatement stmt idx]
    (.setTimestamp stmt idx (java.sql.Timestamp. (.getTime v)))))

(defn book-ticket [params]
(conman/with-transaction [*db*]
  (try (-> params
        (book-ticket!)
        (get-booking)
        (booked-seat!))
(catch java.sql.BatchUpdateException e
    (prn "caught" e)))))

(defn delete-show [params]
(conman/with-transaction [*db*]
  (try 
    (do (delete-bookings params)
        (delete-show-seats! params)
        (delete-show! params))
(catch java.sql.BatchUpdateException e
    (prn "caught" e)))))
