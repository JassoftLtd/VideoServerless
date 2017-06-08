import React, { Component } from 'react';
import {Card, CardText} from 'material-ui/Card';
import PropTypes from 'prop-types';
import VideosDay from "./VideosDay.js"

export default class VideosByDay extends Component {

    render() {
        const {videosByDate, playVideo} = this.props;

        let days = videosByDate.map(function (day, i) {
            return (
                <VideosDay key={day.date} date={day.date} videos={day.videos} playVideo={ playVideo } />
            )
        });

        return (
            <Card>
                {days}
            </Card>
        )
    }
}

VideosByDay.propTypes = {
    videosByDate: PropTypes.array.isRequired,
    playVideo: PropTypes.func.isRequired
};