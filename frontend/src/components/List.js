import React from "react";

import "./List.css";

const List = ({ items }) => {
  if (!items.length) {
    return (
      <div>
        No short URLs created yet
      </div>
    )
  }
  return (
    <ul className="url-list">
      {items.map(({ code, url }) => (
        <li>
          <a target="_blank" href={url}>{code}</a>
        </li>
      ))}
    </ul>
  );
};

export default List;
