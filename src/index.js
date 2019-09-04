import React from "react";
import { render } from "react-dom";

import App from "./components/App";
import Game from "./components/Game";

render(<Game name="World" />, document.getElementById("root"));
