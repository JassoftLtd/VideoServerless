import React, {Component} from 'react';
var authUtils = require('./utils/auth.js');

class Nav extends Component {

    onAuthStateChange(loggedIn) {
        console.log('Account Knows of Auth state change')
        this.setState({loggedIn: loggedIn})
    }

    render() {

        //Authed
        var videoLink
        var accountLink

        //unAuthed
        var signupLink

        if (authUtils.hasAuth()) {
            videoLink = <li><a href="/Video">Videos</a></li>
            accountLink = <li><a href="/Account">Account</a></li>
        }
        else {
            signupLink = <li><a href="/Signup">Signup</a></li>
        }

        return (
            <ul className="Nav">
                <li><a href="/">Home</a></li>
                {videoLink}
                {accountLink}
                {signupLink}
            </ul>
        );
    }
}

export default Nav;
