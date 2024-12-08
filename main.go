package main

import (
	"flag"
	"fmt"
	"net/http"
	"os"
)

func main() {
	port := flag.String("port", "6000", "监听的端口")
	flag.Parse()

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		host, err := os.Hostname()
		if err != nil {
			fmt.Fprintf(w, "%s", err.Error())
			return
		}

		w.Write([]byte(host))
	})

	addr := fmt.Sprintf(":%s", *port)

	fmt.Printf("listen at %s\n", addr)
	panic(http.ListenAndServe(addr, nil))
}
