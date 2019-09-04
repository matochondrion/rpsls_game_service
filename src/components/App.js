import React from "react";
import PropTypes from "prop-types";
import Game from "./Game";

const App = ({ name }) => {
  return (
    <div>
      <h1>Hello, {name}!</h1>
      <h1>Hello, {name}!</h1>
      <Game />
    </div>
  );
};

App.propTypes = {
  name: PropTypes.string
};

export default App;
