import React, { useState, useEffect } from "react";
import "./App.css";

import List from "./components/List";
import Form from "./components/Form";

function App() {
  const [urls, setUrls] = useState([]);

  useEffect(() => {
    async function fetchUrls() {
      const result = await fetch("http://localhost:3000/urls");
      const json = await result.json();

      setUrls(Object.entries(json).map(([code, url]) => ({ code, url })));
    }

    fetchUrls();
  }, []);

  return (
    <div className="App">
      <h1>New short URL</h1>
      <Form />

      <h1>Current short URLs</h1>
      <List items={urls} />
    </div>
  );
}

export default App;
