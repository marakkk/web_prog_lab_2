import beans.Shot;
import beans.ShotCollectionManager;
import org.codehaus.jackson.map.ObjectMapper;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "area-check-servlet", value = "/area-check-servlet")
public class AreaCheckServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter pw = response.getWriter();
        LocalDateTime startTime = LocalDateTime.now(ZoneOffset.UTC);
        ObjectMapper om = new ObjectMapper();
        try {
            float x = Float.parseFloat(request.getParameter("x-value"));
            float y = Float.parseFloat(request.getParameter("y-value"));
            float r = Float.parseFloat(request.getParameter("r-value"));
            log("X: " + x);
            log("Y: " + y);
            log("R: " + r);
            boolean status = isHit(x, y, r);

            if (!validateVariables(x, y, r) && !status) {
                log("variables arent valid");
                response.setStatus(400);
            }

            if (!validateVariables(x, y, r)) {
                log("variables arent valid");
                response.setStatus(400);
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            Shot newShot = new Shot(x, y, r, startTime.minusMinutes(Long.parseLong(request.getParameter("timezone"))).format(formatter),
                    (long) (LocalDateTime.now().minusNanos(startTime.getNano()).getNano() * 0.000001), status);
            ShotCollectionManager.add(newShot);
            log("Shot successfully added");

            getServletContext().setAttribute("shots", ShotCollectionManager.getCollection());
            String responseBody = om.writeValueAsString(newShot);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            pw.write(responseBody);
            pw.flush();
        } catch (NumberFormatException ignored) {
            log("variables arent valid");
            response.setStatus(400);
        }
    }

    private boolean validateVariables(double x, double y, double r) {
        return y > -3 && y < 3 && x >= -3 && x <= 5 && r >= -2 && r <= 3;
    }

    private boolean isHit(double x, double y, double r) {
        return isCircleZone(x, y, r) || isTriangleZone(x, y, r) || isRectangleZone(x, y, r);
    }

    private boolean isRectangleZone(double x, double y, double r) {
        return (x <= 0) && (y <= 0) && (x >= (-1) * r / 2) && (y <= r);
    }

    private boolean isCircleZone(double x, double y, double r) {
        return (x * x + y * y <= r * r) && (x <= 0) && (y >= 0);
    }

    private boolean isTriangleZone(double x, double y, double r) {
        return (x >= 0) && (y >= 0) && (y <= (-2) * x + r);
    }
}
