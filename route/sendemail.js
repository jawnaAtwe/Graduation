const express = require('express');
const nodemailer = require('nodemailer');
            const secure_configuration = require('./secure');
              
            const transporter = nodemailer.createTransport({
              service: 'gmail',
              auth: {
                type: 'OAuth2',
               
              }
            });
              
            const mailConfigurations = {
                from: 'appetizingapplication@gmail.com',
                to: 'jawnaamjad@gmail.com',
                subject: 'Sending Email using Node.js',
                text: 'Hi! There, You know I am using the NodeJS '
                 + 'Code along with NodeMailer to send this email.'
            };
                
            transporter.sendMail(mailConfigurations, function(error, info){
                if (error) throw Error(error);
                   console.log('Email Sent Successfully');
                console.log(info);
            });
            const query = util.promisify(pool.query).bind(pool);
module.exports = query;


