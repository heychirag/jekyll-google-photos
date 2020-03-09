def FlexbinCSS()
  elem = %Q{
              .flexbin {
                display: flex;
                overflow: hidden;
                flex-wrap: wrap;
                margin: -2.5px;
              }
              .flexbin:after {
                content: "";
                flex-grow: 999999999;
                min-width: 300px;
                height: 0;
              }
              .flexbin > * {
                position: relative;
                display: block;
                height: 300px;
                margin: 2.5px;
                flex-grow: 1;
              }
              .flexbin > * > img {
                height: 300px;
                object-fit: cover;
                max-width: 100%;
                min-width: 100%;
                vertical-align: bottom;
              }
              .flexbin.flexbin-margin {
                margin: 2.5px;
              }
              @media (max-width: 300px) {
                .flexbin {
                  display: flex;
                  overflow: hidden;
                  flex-wrap: wrap;
                  margin: -2.5px;
                }
                .flexbin:after {
                  content: "";
                  flex-grow: 999999999;
                  min-width: 75px;
                  height: 0;
                }
                .flexbin > * {
                  position: relative;
                  display: block;
                  height: 75px;
                  margin: 2.5px;
                  flex-grow: 1;
                }
                .flexbin > * > img {
                  height: 75px;
                  object-fit: cover;
                  max-width: 100%;
                  min-width: 100%;
                  vertical-align: bottom;
                }
                .flexbin.flexbin-margin {
                  margin: 2.5px;
                }
              }
              @media (min-width: 300px) and (max-width: 450px) {
                .flexbin {
                  display: flex;
                  overflow: hidden;
                  flex-wrap: wrap;
                  margin: -2.5px;
                }
                .flexbin:after {
                  content: "";
                  flex-grow: 999999999;
                  min-width: 112px;
                  height: 0;
                }
                .flexbin > * {
                  position: relative;
                  display: block;
                  height: 112px;
                  margin: 2.5px;
                  flex-grow: 1;
                }
                .flexbin > * > img {
                  height: 112px;
                  object-fit: cover;
                  max-width: 100%;
                  min-width: 100%;
                  vertical-align: bottom;
                }
                .flexbin.flexbin-margin {
                  margin: 2.5px;
                }
              }
              @media (min-width: 450px) and (max-width: 600px) {
                .flexbin {
                  display: flex;
                  overflow: hidden;
                  flex-wrap: wrap;
                  margin: -2.5px;
                }
                .flexbin:after {
                  content: "";
                  flex-grow: 999999999;
                  min-width: 150px;
                  height: 0;
                }
                .flexbin > * {
                  position: relative;
                  display: block;
                  height: 150px;
                  margin: 2.5px;
                  flex-grow: 1;
                }
                .flexbin > * > img {
                  height: 150px;
                  object-fit: cover;
                  max-width: 100%;
                  min-width: 100%;
                  vertical-align: bottom;
                }
                .flexbin.flexbin-margin {
                  margin: 2.5px;
                }
              }
              @media (min-width: 600px) and (max-width: 750px) {
                .flexbin {
                  display: flex;
                  overflow: hidden;
                  flex-wrap: wrap;
                  margin: -2.5px;
                }
                .flexbin:after {
                  content: "";
                  flex-grow: 999999999;
                  min-width: 175px;
                  height: 0;
                }
                .flexbin > * {
                  position: relative;
                  display: block;
                  height: 175px;
                  margin: 2.5px;
                  flex-grow: 1;
                }
                .flexbin > * > img {
                  height: 175px;
                  object-fit: cover;
                  max-width: 100%;
                  min-width: 100%;
                  vertical-align: bottom;
                }
                .flexbin.flexbin-margin {
                  margin: 2.5px;
                }
              }
              @media (min-width: 750px) and (max-width: 900px) {
                .flexbin {
                  display: flex;
                  overflow: hidden;
                  flex-wrap: wrap;
                  margin: -2.5px;
                }
                .flexbin:after {
                  content: "";
                  flex-grow: 999999999;
                  min-width: 175px;
                  height: 0;
                }
                .flexbin > * {
                  position: relative;
                  display: block;
                  height: 175px;
                  margin: 2.5px;
                  flex-grow: 1;
                }
                .flexbin > * > img {
                  height: 175px;
                  object-fit: cover;
                  max-width: 100%;
                  min-width: 100%;
                  vertical-align: bottom;
                }
                .flexbin.flexbin-margin {
                  margin: 2.5px;
                }
              }
              @media (min-width: 900px) and (max-width: 1050px) {
                .flexbin {
                  display: flex;
                  overflow: hidden;
                  flex-wrap: wrap;
                  margin: -2.5px;
                }
                .flexbin:after {
                  content: "";
                  flex-grow: 999999999;
                  min-width: 175px;
                  height: 0;
                }
                .flexbin > * {
                  position: relative;
                  display: block;
                  height: 175px;
                  margin: 2.5px;
                  flex-grow: 1;
                }
                .flexbin > * > img {
                  height: 175px;
                  object-fit: cover;
                  max-width: 100%;
                  min-width: 100%;
                  vertical-align: bottom;
                }
                .flexbin.flexbin-margin {
                  margin: 2.5px;
                }
              }
              @media (min-width: 1050px) {
                .flexbin {
                  display: flex;
                  overflow: hidden;
                  flex-wrap: wrap;
                  margin: -2.5px;
                }
                .flexbin:after {
                  content: "";
                  flex-grow: 999999999;
                  min-width: 180px;
                  height: 0;
                }
                .flexbin > * {
                  position: relative;
                  display: block;
                  height: 180px;
                  margin: 2.5px;
                  flex-grow: 1;
                }
                .flexbin > * > img {
                  height: 180px;
                  object-fit: cover;
                  max-width: 100%;
                  min-width: 100%;
                  vertical-align: bottom;
                }
                .flexbin.flexbin-margin {
                  margin: 2.5px;
                }
              }
              .stage{
                  position:absolute;
                  width:100%;
                  height:100%;
                  background-color: black;
                  top:0;
                  left:0;
                }
                .stage img {
                    position:absolute;
                    left:0; right:0;
                    top:0; bottom:0;
                    margin:auto;
                    max-width:100%;
                    max-height:100%;
                    overflow:auto;
                }
              }
  return elem
end

public :FlexbinCSS
