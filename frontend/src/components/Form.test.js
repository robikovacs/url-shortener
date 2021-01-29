import React from "react";
import { render } from "@testing-library/react";
import userEvent from '@testing-library/user-event'
import Form from "./Form";

const PLACEHOLDER_TEXT = "Enter url";

it('types inside input', () => {
  const { getByPlaceholderText } = render(<Form />);
  const subject = getByPlaceholderText(PLACEHOLDER_TEXT)
  userEvent.type(subject, 'Hello, World!')
  expect(subject).toHaveValue('Hello, World!')
})

it("submits the form", () => {
  const onSubmit = jest.fn();
  const { getByPlaceholderText, getByText } = render(<Form onSubmit={onSubmit} />);
  const inputValue = "https://deliveroo.co.uk/";

  const subject = getByPlaceholderText(PLACEHOLDER_TEXT)
  userEvent.type(subject, inputValue)
  userEvent.click(getByText(/Save/i));

  expect(onSubmit).toBeCalled();
});
