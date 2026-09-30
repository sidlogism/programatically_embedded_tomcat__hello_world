package sidlogism.experiments;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.connector.Connector;

public class TomcatLauncher {

	public static void main(String[] args) throws LifecycleException {
		// initialize embedded Tomcat server
		final Tomcat tomcat = new Tomcat();
		tomcat.setBaseDir("temp");
		tomcat.setPort(9876);

		final Connector conn = new Connector("org.apache.coyote.http11.Http11NioProtocol");
		conn.setPort(9876);
		tomcat.setConnector(conn);



		// initialize new servlet context (web application)
		final String contextPath = "";
		final String docBase = new File(".").getAbsolutePath();

		final Context context = tomcat.addContext(contextPath, docBase);



		// initialize example servlet: helloworldServlet
		final HttpServlet helloworldServlet = new HttpServlet() {
			@Override
			protected void doGet(HttpServletRequest req, HttpServletResponse resp)
					throws ServletException, IOException {
				final PrintWriter writer = resp.getWriter();

				writer.println("<html><title>Welcome</title><body>");
				writer.println("<h1>HelloWorld!</h1>");
				writer.println("<label for=\"myfield\">Dummy-Textfeld</label><br>");
				writer.println("<input type=\"text\" id=\"myfield\" name=\"exampleInput\" value=\"bitte Text eingeben\"><br>");
				writer.println("</body></html>");
			}
		};

		String servletName = "helloServlet";
		String urlPattern = "/hello";
		tomcat.addServlet(contextPath, servletName, helloworldServlet);
		context.addServletMappingDecoded(urlPattern, servletName);



		// initialize example servlet: summation of URL-parameters
		final SummationServlet summationServlet = new SummationServlet();
		servletName = "sumServlet";
		urlPattern = "/sum";

		tomcat.addServlet(contextPath, servletName, summationServlet);
		context.addServletMappingDecoded(urlPattern, servletName);



		// launch embedded Tomcat server and wait until Tomcat instance is shutdown externally
		tomcat.start();
		tomcat.getServer().await();
	}
}