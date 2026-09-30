package sidlogism.experiments;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SummationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        final int a = Integer.parseInt(req.getParameter("a"));
        final int b = Integer.parseInt(req.getParameter("b"));
        final int sum = a + b;

        final String result = String.format("%d + %d = %d", a, b, sum);

        final PrintWriter writer = resp.getWriter();
        writer.println("<html><title>Summation</title><body>");
        writer.println("<h1>" + result + "</h1");
        writer.println("</body></html>");
    }
}
