import React, { useState, useEffect } from "react";
import "./App.css";

import List from "./components/List";
import Form from "./components/Form";

const ERROR_MESSAGES = {
  blank_url: "URL cannot be blank!",
  invalid_url: "Invalid URL"
}

const errorMessage = (key) => {
  return ERROR_MESSAGES[key] || "Something went wrong";
}

function App() {
  const [urls, setUrls] = useState([]);
  const [error, setError] = useState("")

  useEffect(() => {
    async function fetchUrls() {
      const result = await fetch("http://localhost:3000/urls");
      const json = await result.json();

      setUrls(Object.entries(json).map(([code, url]) => ({ code, url })));
    }

    fetchUrls();
  }, []);

  const submitUrl = async (newUrl) => {
    setError("")
    const result = await fetch(
      "http://localhost:3000/urls", 
      { 
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({url: newUrl})
      }
    );
    const json = await result.json();
    
    if(!result.ok) {
      setError(errorMessage(json['error']))
      return;
    }

    setUrls([...urls, {url: newUrl, code: json['code']}]);
  }

  return (
    <div className="App">
      <h1>New short URL</h1>
      <Form onSubmit={submitUrl} />
      {error && <div>{error}</div>}

      <h1>Current short URLs</h1>
      <List items={urls} />
    </div>
  );
}

export default App;
