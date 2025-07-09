//This is an example code to Load Local HTML File in WebView//
import React, { Component } from 'react';
//import react in our code. 

import { StyleSheet, Platform } from 'react-native';

import { WebView  } from 'react-native-webview';

//import all the components we are going to use. 
// const html1 = require('./resource/index.html');
// const html2 = require('./resource/PrivacyPolicy.html')
class PrivacyPolicy extends Component {
  render() {
    return (
      <WebView
        style={styles.WebViewStyle}
        //Loading html file from project folder
        source={{html: require('./resource/PrivacyPolicy.js')()}}
        
        //Enable Javascript support
        javaScriptEnabled={true}
         //For the Cache
        domStorageEnabled={true}
      />
    );
  }
}
export default PrivacyPolicy;
const styles = StyleSheet.create({
  WebViewStyle: {
    justifyContent: 'center',
    alignItems: 'center',
    flex: 1,
    marginTop: 30,
  },
});
