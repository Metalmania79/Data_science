import os
os.environ['PYTHONIOENCODING'] = 'utf-8'

import streamlit as st
import numpy as np
import cv2
import traceback
import tempfile
from tensorflow.keras.preprocessing.image import img_to_array
from tensorflow.keras.models import load_model


# -----------------------------------------------------------------
# CUSTOM FUNCTIONS
#------------------------------------------------------------------

def stop_webcam():
    st.session_state.running = False
def start_webcam():
    st.session_state.running = True

#---------------------------------------------------------
# Streamlit part
#---------------------------------------------------------
st.title("Kunskapskontroll - Face Detection")

# Initialize session state for camera
if 'running' not in st.session_state:
    st.session_state.running = False

# Create a placeholder for the video stream
video_placeholder = st.empty()


# Build a sidebar to load the model you want to use
with st.sidebar:

    filename = st.file_uploader("Choose your model for prediction (.keras)", type=["keras"])

    if filename is not None:

        # Save the uploaded file temporarily because file_uploader returns an object and that is not what load_model wants
        with tempfile.NamedTemporaryFile(delete=False, suffix=".keras") as temp_file:
            temp_file.write(filename.getbuffer())
            cached_model = temp_file.name

        # Debugging: Check if the file was written correctly
        if os.path.exists(cached_model):
            st.sidebar.write("Model file cached successfully.")
        else:
            st.sidebar.write("Error: Model file not cached.")

        # Load the model 
        try:
            model = load_model(cached_model)
            st.sidebar.write("Model loaded successfully.")
            model.summary(print_fn=st.sidebar.write)
        except Exception as e:
            st.sidebar.write(f"Error loading model: {e}")
        finally:
            # Clean up the temporary file
            os.remove(cached_model)

# Load the Haar cascade for face detection
find_face = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
class_names = ['angry', 'disgust', 'fear', 'happy', 'neutral', 'sad', 'surprise']

# Display Start and Stop buttons
if not st.session_state.running:
    st.button('Start', on_click=start_webcam)
else:
    st.button('Stop', on_click=stop_webcam)

# Access webcam (0 is the default camera) when model is loaded and start is clicked
if st.session_state.running:
    cap = cv2.VideoCapture(0)

    # Check if the webcam is opened correctly
    if not cap.isOpened():
        st.error("Error: Could not open video stream.")
    else:
        st.write("Webcam connected!")

        # Capture frames from the webcam
        while cap.isOpened() and st.session_state.running:

            ret, frame = cap.read()

            if not ret:
                st.error("Error: Failed to capture image.")
                break

            # Convert the frame to grayscale
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

            # Detect faces in the frame
            faces = find_face.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

            # Draw rectangles around detected faces
            for (x, y, w, h) in faces:
                
                cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 0, 255), 2)

                # Extract the face from the frame
                grayface = gray[y:y+h, x:x+w]

                # Preprocess the face for prediction
                face = cv2.resize(grayface, (48, 48), interpolation=cv2.INTER_AREA)           # Resize to the input size expected by the model
                
                # DEBUG - Show the face region before prediction--------------------------------
                # face_holder = st.empty()
                # face_display = cv2.cvtColor(face, cv2.COLOR_GRAY2RGB)
                # face_display = face_display.astype('float32') / 255.0 
                # face_holder.image(face_display, channels="RGB", caption="Face Region", clamp=True)
                #-------------------------------------------------------------------------------
                
                face = img_to_array(face)
                face = np.expand_dims(face, axis=0)              # Add batch dimension
                face = face.astype('float32') / 255.0           # Normalize pixel values
                
                # Debugging
                # print(f"*******************Face Array:\n{face}")
                # print(f"*******************Face Array:\n{face.shape}")
                # print(f"*******************Face Array:\n{len(face)}")
                #break
                
                try:

                    # Make prediction
                    prediction = model.predict(face)        # Krashar om du kör webservern i Git bash, använd win terminal
                    ## This could be a bug in Keras: https://github.com/keras-team/keras/issues/19386
                   
                    # Display each prediction above the face rectangle
                    for i, (class_name, pred) in enumerate(zip(class_names, prediction[0])):
                        text = f"{class_name}: {pred:.2f}"
                        cv2.putText(frame, text, (x, y - 10 - i*20), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 0), 2)

                except Exception as error:
                     
                     if np.isreal(face).all():
                        st.text("All values in the face array are numbers.")
                     else:
                        st.text("The face array contains non-numeric values.")

                     st.text(f"Face shape: {face.shape}")
                     st.text(f"Face dtype: {face.dtype}")
                     st.text(traceback.format_exc())

                     st.error(f"Error in prediction {error}")
                     break

            # Convert the frame to RGB (OpenCV uses BGR by default)
            frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

            # Display the frame in the Streamlit app
            video_placeholder.image(frame, channels="RGB")

        # Release the webcam
        cap.release()
        st.write("Webcam stopped.")
else:
    st.info("Please upload a .keras model file.")
