import React, { useState } from "react";

const Form = ({ onSubmit }) => {
  const [url, setUrl] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    onSubmit(url);
  };

  const handleUrlChange = (event) => {
    setUrl(event.target.value);
  };

  return (
    <form className="form" onSubmit={handleSubmit}>
      <input
        placeholder="Enter url"
        onChange={handleUrlChange}
        value={url}
      ></input>
      <button type="submit">Save</button>
    </form>
  );
};

export default Form;
