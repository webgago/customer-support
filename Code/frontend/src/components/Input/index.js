import React from 'react'

export const Input = ({ input, label, type, meta: { touched, invalid, error } }) => {
  const errorClass = () => hasError() ? 'has-error' : 'has-success'
  const hasError = () => touched && invalid && error

  return (
    <div className={'form-group ' + errorClass()}>
      <label>{label}</label>
      <input type={type} className='form-control' {...input} />
      {touched && error && <span className='help-block'>{error}</span>}
    </div>
  )
}

Input.propTypes = {
  input: React.PropTypes.object.isRequired,
  label: React.PropTypes.string.isRequired,
  type: React.PropTypes.string.isRequired,
  meta: React.PropTypes.object.isRequired
}
export default Input
