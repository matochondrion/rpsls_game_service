import React from "react";
import PropTypes from "prop-types";
import axios from "axios";

import "../assets/styles/App.scss";

class Game extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      choices: [],
      choice: "",
      message: "Messages go here."
    };
  }

  handleClick(index) {
    let newState = Object.assign({}, this.state);
    newState.choice = this.state.choices[index].choice.name;
    newState.message = this.state.choices[index].choice.name;
    this.setState(newState);

    // alert(index + ": Game Component. choice: " + this.state.choice);
  }
  componentDidMount() {
    axios
      .get("/api/choices")
      .then(res => {
        const retrievedChoices = res.data;
        let newState = Object.assign({}, this.state);
        newState.choices = retrievedChoices;
        newState.message = "choices data retrieved";

        this.setState(newState);
      })
      .catch(error => {
        this.setState({ message: error.message });
        alert(error.message);
      });
  }

  render() {
    return (
      <div className="game">
        <Message message={this.state.message} />
        <h2>Player, make a choice to play against the Computer</h2>
        <div>{/* status */}</div>
        <div>Choose for me</div>

        <Choices
          choices={this.state.choices}
          onClick={index => this.handleClick(index)}
        />
      </div>
    );
  }
}

class Choices extends React.Component {
  handleClick(index) {
    this.props.onClick(index);
  }

  render() {
    const choices = [];

    for (const [index, item] of this.props.choices.entries()) {
      choices.push(
        <Choice
          key={index}
          index={index}
          name={item.choice.name}
          onClick={index => this.handleClick(index)}
        />
      );
    }

    return <ul className="choice-list">{choices}</ul>;
  }
}

class Choice extends React.Component {
  handleClick(index) {
    this.props.onClick(index);
  }

  render() {
    return (
      <li
        id={"choice-" + this.props.name}
        class="choice-container"
        onClick={() => this.handleClick(this.props.index)}
      >
        {this.props.name}
      </li>
    );
  }
}

class Message extends React.Component {
  render() {
    return (
      <div>
        <h3>message:</h3>
        <div>{this.props.message}</div>
      </div>
    );
  }
}

export default Game;
