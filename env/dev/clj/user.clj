(ns user
  (:require [mount.core :as mount]
            my-auditorium.core))

(defn start []
  (mount/start-without #'my-auditorium.core/http-server
                       #'my-auditorium.core/repl-server))

(defn stop []
  (mount/stop-except #'my-auditorium.core/http-server
                     #'my-auditorium.core/repl-server))

(defn restart []
  (stop)
  (start))


