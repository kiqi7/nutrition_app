// web/permissions.js
class WebPermissions {
    static async requestCameraPermission() {
        try {
            const stream = await navigator.mediaDevices.getUserMedia({ 
                video: true,
                audio: false
            });
            // Stop the stream immediately since we just want the permission
            stream.getTracks().forEach(track => track.stop());
            return true;
        } catch (error) {
            console.error('Camera permission error:', error);
            return false;
        }
    }

    static async checkCameraPermission() {
        try {
            const result = await navigator.permissions.query({ name: 'camera' });
            return result.state === 'granted';
        } catch (error) {
            console.error('Check camera permission error:', error);
            return false;
        }
    }
}

// Make it available globally
window.WebPermissions = WebPermissions;