(ns my-auditorium.env
  (:require [clojure.tools.logging :as log]))

(def defaults
  {:init
   (fn []
     (log/info "\n-=[my-auditorium started successfully]=-"))
   :stop
   (fn []
     (log/info "\n-=[my-auditorium has shut down successfully]=-"))
   :middleware identity})
